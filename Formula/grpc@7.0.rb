# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT70 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.50.0.tgz"
  sha256 "2e0bebc351d9cb07ef1d3685f3c4f976d297bbf946479c5e4be4ecaaa3500927"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "a5ffaf3bd184252195140c31a3392d3fe5a7c0eed5cd6fe6f4c1b7a8e6739098"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "74122e08e602b5ab20ce043419369df1cc97dc89e4292caa3d48bfd14b003863"
    sha256 cellar: :any_skip_relocation, monterey:       "44ed5278c47edf384149e90c4daf960aa48ce4573e68cd26f6d7a4326863a65b"
    sha256 cellar: :any_skip_relocation, big_sur:        "06e83e9c9ab8d4e964816996228501ad3d8227b822869755a1b96030100363cc"
    sha256 cellar: :any_skip_relocation, catalina:       "1ecc7c6bcc7e0e47ded85f847a2e54823240450bbf35c0ac1abcd6d95ce90073"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "2aa5307638136f987327e75ad1bc5299b97ca5182ec4edc7b65e89d850e7ef0a"
  end

  depends_on "grpc"

  def install
    Dir.chdir "grpc-#{version}"
    safe_phpize
    system "./configure", "--enable-grpc"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
