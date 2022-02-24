# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT71 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.44.0.tgz"
  sha256 "f6d6be7e1bd49b3aae7ada97233fe68172100a71a23e5039acb2c0c1b87e4f11"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "35051e36d7df7c3f7f3862f314d2d260b1ef4718cce588ab88bce694781d4a06"
    sha256 cellar: :any_skip_relocation, big_sur:       "f064ea94a03d95da78399e83e4046bc82049a155264aa7771fe63e3e14c10a94"
    sha256 cellar: :any_skip_relocation, catalina:      "7c073369eeb72d40b0cd5c8b5867d53aebbb9e7f3f6bad25090b04a7fe1d9a7f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "308c1162afd12c506da1c2ec4e58dd6b6517adb8ece94ddcb5ab180a68fbbdd6"
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
