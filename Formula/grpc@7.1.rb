# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT71 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.81.1.tgz"
  sha256 "3c9086743a29bda3b5bd323e31f9c6da6e04900288ab37f0da1df8859a2ee8f5"
  head "https://github.com/grpc/grpc.git", branch: "master"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/grpc/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "7cc0b8f4cf6284c9ea1dbf5638b588a92f447a0f6cb7f6a9c1417fc5238e2a45"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "93a6eb7eeea8b2026b0dbc53b5f00070ede44786a2281813f778543d0b726921"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "f323bce1fd683d14a99eda3b6fbbd3f6173211197b0d36d5e463da0071d3ca4d"
    sha256 cellar: :any_skip_relocation, sonoma:        "843c369dd63f620e065c2e55ff153e3a45f9d9e9e13d724ecd429b4d24ee28fa"
    sha256 cellar: :any,                 arm64_linux:   "fa9348e40832f7432529142ec01743fa1e6c11046afaeadb4f77ec56211365cf"
    sha256 cellar: :any,                 x86_64_linux:  "4f3d909f7eb5726869245b90e4911ff0dc72efafd01d74bd61bed3ed2dff7a53"
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
