# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT84 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.66.0.tgz"
  sha256 "6f6b751bbf33a88f917ca11a5b32923223c106eb5f064b791f99c6f7a9c7e7c2"
  head "https://github.com/grpc/grpc.git", branch: "master"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "9ecfc170c9b627d8401c011de194d2d92e0f1939183eaec033ff9180b23f5c47"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "98812a5561379fc015b1ee69c637ac28778424a5f9a3f46ddd0330158cf414bb"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "ea3bd5e244441e7f2faebb9a39a57fc081765e61b73c239d722152025d172f63"
    sha256 cellar: :any_skip_relocation, ventura:       "fb82d29d1a877fb38e9acb6d7c7ce18a0b894f89997f409555ec81dda75fd70d"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "1e9a973e9e704a405ceb35ef643b92f90168afba030980fdd27bd1ab8839f2b4"
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
