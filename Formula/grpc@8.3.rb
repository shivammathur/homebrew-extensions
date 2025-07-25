# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT83 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.74.0.tgz"
  sha256 "972ce8a989f2c15a951444950c1febe84eb88e59aeaca29d96e005fe55df1fc3"
  head "https://github.com/grpc/grpc.git", branch: "master"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/grpc/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "d9249d4f2eadd2d4a986802bdacc5a2a4b458634aa54bfdff1de25f69b17c362"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "de325e18b39a49b3829ee543266c64deddb41d5f5a6888138c0566775151f4a5"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "2a1e654e7ce1ce9d784d41eec2a3fa4aa0cf8a43500b381ee31648035b72ee83"
    sha256 cellar: :any_skip_relocation, ventura:       "30960848ba90ca169c6733727d60f5299e01dc926c50eeb0092952f90af31bee"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "db1e423743298c2c6c35edebcf9a2afae7fd1041f51da80631cadbd20e17e9c4"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "857083fe9e8e330be2b915f11fc17445d5a4a4e494dd6ff4397f27ab82abbb1c"
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
