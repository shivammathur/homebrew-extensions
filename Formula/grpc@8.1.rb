# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT81 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_golden_gate: "28f7af7d34f9ee519b3eb0a487062ea16a1c785feb16659d719d11f07f803311"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:       "e6cb645edbb3340a0f3f0a25f48a6a4ecb0b453d5f4d673735a8587b1607fbbd"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:     "65c79880a612e9ead23d712ef53e1d3bb57b8e67376eda97ebce1f9c2714158b"
    sha256 cellar: :any,                 arm64_linux:       "52068dcf895254a8c71585e069055313d94a16e157c619c755d08d52f055fec0"
    sha256 cellar: :any,                 x86_64_linux:      "b312c3d1b9f20d2d7d63ed97d72aa06013da0afc26faa7d7f35beebe6f236d4f"
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
