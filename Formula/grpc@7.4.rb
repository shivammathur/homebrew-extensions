# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT74 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.37.0.tgz"
  sha256 "591317e428276a05ca578dce778d4ade47d777a1efa9509db4dd480f82a5e822"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "73357f9161e20d2899c36028ff27ca48d5a30b025b3299d05ae2b507bfdb22d8"
    sha256 cellar: :any_skip_relocation, big_sur:       "41b712d4f0e9a89105e1fc4e23bee9bad3c32d026b4a9bb2cf6f0d9217f0d197"
    sha256 cellar: :any_skip_relocation, catalina:      "95afac63449d28d041ba5cff13092297ed2952a74744d48dee8f003a56020ca8"
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
