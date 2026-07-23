# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT73 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.83.0.tgz"
  sha256 "b12c7e0e048df728a4f2c513aeaa78ae18ad5c3ab3b607eeae398e0e1bab12ea"
  head "https://github.com/grpc/grpc.git", branch: "master"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/grpc/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "bfd6b5aaa3effb954f7cef222525c61195929222a186efdbd821c65bdc846bc5"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "80decf87473f8d17f8e6b119450a66299ef2c1b6bed46f327a69b6df32b18f64"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "79f30b709720d13a7c6f370ecc79423a41e31ec86fbf4c62c78477f8d5e74d49"
    sha256 cellar: :any_skip_relocation, sonoma:        "15071251c37e74c41b72fd2e7e14fc4f2dac43d74e9c859a6db19e02e6d6550d"
    sha256 cellar: :any,                 arm64_linux:   "dd912eaf9488a1c32baefd4d84f298f559a10413958c714c62f43e4cda68ec36"
    sha256 cellar: :any,                 x86_64_linux:  "e20be2324ddd429c4916b3584640f71cb678e948df688558d1d7ab4a171825f8"
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
