# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT73 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.85.0.tgz"
  sha256 "adaf30db949767bf0ff5a5308638e4b9bb5f711733204ed5a5e8f3014d80a174"
  head "https://github.com/grpc/grpc.git", branch: "master"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/grpc/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_golden_gate: "0ba740c2adb949a336e5ada0b3ffadda78ee6690b012efa463e65c0e9eafcbfd"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:       "d25b8fefbf5fe94ec75bfef9ab2ca888b329d4e16c10c141304ee6ae61ff823a"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:     "4a15f8cffd997bad41a45fd8636d8f1291aa43e03aa62e18fd08b0df85b102c3"
    sha256 cellar: :any,                 arm64_linux:       "b1512f6d353e44221c8eed9481d21f9cb2d898c4b13299a76e969a48f2e1f241"
    sha256 cellar: :any,                 x86_64_linux:      "d45e236eafcd78fb850639f7646c25c59c82e924417be1628748bdb2c3180922"
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
