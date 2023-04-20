# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT83 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.54.0.tgz"
  sha256 "5ad3c1a046290f901771fc3f557db6c5bdd4208e157f42a0ab061cf10ac0dfa9"
  head "https://github.com/grpc/grpc.git", branch: "master"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "919144064ab67dd21a1fe27ebbbf06637be84d9c01a22fbc0fc84ba7bbf264bc"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "06fb014f07ad38c691df0ea980edb879513e8d171527679586d9ff14f3b87f16"
    sha256 cellar: :any_skip_relocation, monterey:       "9e4333f7020091736691b740b9170e8421136df264885c96cf53371c488fe793"
    sha256 cellar: :any_skip_relocation, big_sur:        "6501e6ae903f173d64585b8293323e61561c40b4b2a5b190b75fdcbe9b8f56b1"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "3c3c84b67588773dea869aa7164f4e1eb7efd16730351c1c08a66a91839db584"
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
