# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT70 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_golden_gate: "9d29b658107fd7e903a9e39aed152381b9878d1f375118d02050cecd04c6a734"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:       "fde94a45f4abdc1fc08e3db208b16c2c6fd389d1b47f98538d5c37fc94cc21d3"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:     "73d3584b7c6af58f15c9c178e6304e489d4dbacc2d467995178d7d5022f44a51"
    sha256 cellar: :any,                 arm64_linux:       "b9788bd6f0f6b2cbf0c016d4b0be9697b3be64110f4ea2e556acd3036c8629d0"
    sha256 cellar: :any,                 x86_64_linux:      "d5d5b260fc4059eed033fcae419a39663679050a1b9b7a8880845e70751c4623"
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
