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
    sha256 cellar: :any_skip_relocation, arm64_golden_gate: "816ce43ba927c8e0bd64c03fad29df075b7d4e338236ae76f65d52de3f82c9e9"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:       "ad80a9206da60db27da902302b3d8e9f99189565fe42a329e0525eee1497f6da"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:     "e26d0d3fcb3fe0ffb9090a79bda329462bac514e7506ecc208db79de985a1b0c"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:      "e034350b875bcc18b8ef5ed8c8a3e41bde1677ff5c15181e59dc9cfb095821c8"
    sha256 cellar: :any,                 arm64_linux:       "959e63d808559fd671d33f85b2668b554f75262726e3830632dd376de8ed2ad3"
    sha256 cellar: :any,                 x86_64_linux:      "f15d664d9d7707313e56236363383ca428c7fa2073e53756717fc87b6bf5e74d"
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
