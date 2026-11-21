# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT72 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.85.4.tgz"
  sha256 "eb584cbe54ff361a54a9c0628bb3273b141e7900f5a6d89a43f97137875d7cec"
  head "https://github.com/grpc/grpc.git", branch: "master"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/grpc/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_golden_gate: "9d6ddd42b3e5ec39f0dd82c9ae57da4b9be14bbfe476bf9515e949daf9e8237d"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:       "a2b4721b5eb4110cd26e362676bca38e79f485c8669c19e2015b5a1a9aa9b660"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:     "1e7abcfe73687c7a96a5e34cd439df448bbdbae79ffda88e12d8eb424d223cdb"
    sha256 cellar: :any,                 arm64_linux:       "7eeda5816a28eb0f7f9831fb6d9c570c194be2a1ae67bfaee2da32fec7007e02"
    sha256 cellar: :any,                 x86_64_linux:      "e8f35610de4392b6edc544baaa743ca107ff65e0d5ed52d5f48ff9f9465aefee"
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
