# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT83 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.66.0.tgz"
  sha256 "6f6b751bbf33a88f917ca11a5b32923223c106eb5f064b791f99c6f7a9c7e7c2"
  head "https://github.com/grpc/grpc.git", branch: "master"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:  "33e3b6ef9131325809e063a61ec5b66b1390efb18511058f2792cedf256a7c4f"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "6fc120dbb6c4864d0acda2543495aa8ec34d61d556c3f61df42f195f29432ab9"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "05e99d2527b89ac9f924e3893bd505380db62be9af026d19b01497525ca2beb2"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "1b8bfd2d647f2395fc88d2ea3f018291ccb3c1db2afc661fabe6402a82ca4a7f"
    sha256 cellar: :any_skip_relocation, ventura:        "339d90d463d3ed3595d693760a11270a1d64ef45b6dbb5e7c26b03023b1f4157"
    sha256 cellar: :any_skip_relocation, monterey:       "d68ab736c8134ddd41f789d85357b4452201fb7ee114d5fca516f52e18930ae3"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "465ef6b1bf93a5a824323a7fffc6abbd63c52c676f753ca59d65f059f7b33322"
  end

  depends_on "grpc"

  def install
    Dir.chdir "grpc-#{version}"
    patch_spl_symbols
    safe_phpize
    system "./configure", "--enable-grpc"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
