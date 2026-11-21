# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT74 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_golden_gate: "7a6356ff6c6bd8f2f692de414251490cca3417fae0eeadf8378e8ffd372b5305"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:       "b66d6d5320d021bc077a2e5d0ba8f59ca52e47ce96d7f9602022297125728044"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:     "de890928c05af81ab8ef913277e52c43f2c2640beb23177ec2388b1845ff4a26"
    sha256 cellar: :any,                 arm64_linux:       "c0c0b80c6234684246e2056913411a19c1a932fc989533f51d9844e6ebacdbe5"
    sha256 cellar: :any,                 x86_64_linux:      "8ac163cdcad65f009435d901e184370b3134bbc61f9ef360fca2fcde2c94dfe8"
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
