# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT73 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_golden_gate: "7faf349e6947cd4db4daf961e3b9ff84e57508ae989fdde75dae19767fffe52f"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:       "07ef82ed50d45f96dbd07e292d30588a6c3c8f282ac0da196dbfa5952fda3c47"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:     "4e0ee54690957e6d13999e1e28e14646381c9c7a8893fbe38c99df11bc2e9894"
    sha256 cellar: :any,                 arm64_linux:       "d523461c070ade73ca0e00c0b086dba552c4b6c8aaa3fe3ee8bafd34b928c53a"
    sha256 cellar: :any,                 x86_64_linux:      "302dcafff379fe03a6d41c12a299b4ab373dea65c4f9dbf6a8816473d7777035"
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
