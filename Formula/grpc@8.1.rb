# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT81 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_golden_gate: "dc33e1331669ab76dc4fc3f534a065f6a1a8dcb4c3a6a05ab25f8b8a2fd16c0e"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:       "40684eb303ec05f5e3269913eeb11b4e327065ec7774d1e6a1fc4705540744a7"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:     "27761da1ef2b92c3e11171ac37651f90f9c8f6446f3fcc21609f472c305438a4"
    sha256 cellar: :any,                 arm64_linux:       "7474db4b887bdfac0ee9fa27d0fd8aae21e39f75357f59b1fd2f4ca9d1195dc5"
    sha256 cellar: :any,                 x86_64_linux:      "a3a844721eb61b90197cfea4cd237abce6ddcdd784587026885b27baf6a270e8"
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
