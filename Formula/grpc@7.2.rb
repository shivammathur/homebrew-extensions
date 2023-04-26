# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT72 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.54.0.tgz"
  sha256 "5ad3c1a046290f901771fc3f557db6c5bdd4208e157f42a0ab061cf10ac0dfa9"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "94853245d776ed930e97eeb8f27bc427348a034c410854323a23ce410835f590"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "04331cefe6a0dad44de9c402739e9b0ee67d117c7531175d48e1f72b4301d41d"
    sha256 cellar: :any_skip_relocation, ventura:        "d4b2364c8fdb09111ba768b1b7f432a486af1100c65b7c642387f1e9e40e516b"
    sha256 cellar: :any_skip_relocation, monterey:       "4ca33456975fef244834b1273810c2735f6740b527290c5a426082a2123caaea"
    sha256 cellar: :any_skip_relocation, big_sur:        "5b66b644f833da17b5fee5104810d016820b397d3e1ff652eb65f44b6d1ecea6"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "caf729c7d4b9c279db7db5e885eeed52ae1a9dd465c443f5c71804c737b7bdba"
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
