# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT82 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.50.0.tgz"
  sha256 "2e0bebc351d9cb07ef1d3685f3c4f976d297bbf946479c5e4be4ecaaa3500927"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "8f505cd921beef555370b82b47cd958ca08ae13be826ff3abbaea03d1d34be5c"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "7614af9fe4edbd2bead10603df74ea310b364a741736c3c033a0d20320716f69"
    sha256 cellar: :any_skip_relocation, monterey:       "bfb6aa85e183325db4a38a6bfb0632d423afdadc18870440514219a6b94bae2c"
    sha256 cellar: :any_skip_relocation, big_sur:        "57eef26c3b6d441e89ceceea6e8069de16aaa166919db1c4baa534d5df36e9ca"
    sha256 cellar: :any_skip_relocation, catalina:       "b65164def9e52b8189ade533cf2cf4ee5f0b7c38b843700bcaf9c325b0f0f630"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "d0422da3c2e180c0fc00b1431027bef423c69bda8b67f3aaa711768b1e9f9a9c"
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
