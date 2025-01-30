# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT83 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.69.0.tgz"
  sha256 "85ef59edd3517b377736c49a73799ead4729a82b960474b8842c9f89d2fbf222"
  head "https://github.com/grpc/grpc.git", branch: "master"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "9e7ed8585f45e44e71c8e85fde57c2966b279abdf12e08e7e624618604bc3faa"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "a7cae9d6b92b50a66e786ccd61a39efd2e19a2800dd65fc13c0edde1106e1f0b"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "3d2b60e059db4f166de69a93b6666e40b9a47e94e6bd5a38482905f491c04942"
    sha256 cellar: :any_skip_relocation, ventura:       "87bbd6a281baa952ce15e672623fb3ac6ee00bea7b9edc998163ee4f0c60e6c4"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "c5aab74efe2401d356885b66ec58bbcf846b5cbe45837adad2a426524d88641a"
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
