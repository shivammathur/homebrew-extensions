# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT73 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.59.1.tgz"
  sha256 "d789aab7c791647907c3bc3af2bd6b6e97348d1b50eaa59826be61c4a3c3d3ee"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "896ef91a55022b8193a25bfdbb0abe6626f48a68c4c68ac14d4eddf40f5e49ca"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "8ebf3df23bb9d488a81fe244a667912028fb80c0eed2ab832c9ee305f15278d2"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "dd21da309359cfe8eda359ef02c92f7878ddc3894f124e812fdb02b5d44df20a"
    sha256 cellar: :any_skip_relocation, ventura:        "3312f81b1c7528cc9425491a8d3c0c2e04b1f41ca70f8cf486ab6cd3de990a9e"
    sha256 cellar: :any_skip_relocation, monterey:       "9e8c421aeaeaa0daf7810524bf2e99d376da8a061453f21de910a48869a4335a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "3770e3699ee0a1566967851d7e38c2f9b1340aa07de5869d2e0b599d3ce97c9d"
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
