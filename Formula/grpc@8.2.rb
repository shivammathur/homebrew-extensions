# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT82 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_golden_gate: "1e18c32aec6d7253fa64ae20ddda6dc3ba45ebcde2d3abb5f5115fcc60197c24"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:       "50aaae411a3c2d5624e620c09c40731f431a1725f44ea5cff24eb85fea23e85a"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:     "508393f926358bfb78f1e56baf1d747e0da1b19bfa92c3d120f1abcbcf100a38"
    sha256 cellar: :any,                 arm64_linux:       "76736fc93a9a23962e415ffc94770044f838fa0ffb8ef218e762c016437913eb"
    sha256 cellar: :any,                 x86_64_linux:      "938b67a9df51b67af097f1749ef4f398382efb741b9408f2b1ca819011b3a013"
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
