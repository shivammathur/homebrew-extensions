# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT80 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.84.0.tgz"
  sha256 "555716233a5cc9a6baa605719f87b7688a88fb8bfdd9b4493396276244d56625"
  head "https://github.com/grpc/grpc.git", branch: "master"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/grpc/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "19fd67fb61f8ad2592364ff913afd525aed4e846a0fb210a535883c32f56da42"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "686e0af00bf20686fe927f39e6bfa230e7f61527a22f2649325a7c29ef1a3cda"
    sha256 cellar: :any,                 arm64_linux:   "0ac175257df07d95f3f4b21a4979daba203302c6eb663af092efd39bf2151c33"
    sha256 cellar: :any,                 x86_64_linux:  "ec2409828121e996658ec21b9a2c99d0d3045a69c13e54680a2e0f7b9b22c597"
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
