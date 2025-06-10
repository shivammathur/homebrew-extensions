# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT70 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.73.0.tgz"
  sha256 "63959dc527c60cdb056842c5e5ebb45b507452bb121653604ed94c1c23972c7d"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/grpc/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "4ad08b5ebf24123f5ac6f1318a42c9bb1539e46dd17f5f0d35eb07771df90b0a"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "ce3499859763be917d5c3db07bf9a3a31b14f08c32bab0a61e108e455319de39"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "1e8923b3aac6ac796a7fb381472b3e84e4a662d073b6f6c81851a7467b873f56"
    sha256 cellar: :any_skip_relocation, ventura:       "8f452d32617a7ae52af39af2f826e2d312ee81d0187ec6703f22664bb4005fdd"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "53d03d67d4345f07d505d06764217dba91887658d08ccdea2336f734b4cd27d3"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "2ca9272424bcd1d8b97b736df61582f1f9683bf2a0b1a79c0f64867c158a2545"
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
