# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT73 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.76.0.tgz"
  sha256 "6e3d65695bb99de227054ae6431cee29cebabdee699ded55e97fc6f892eb4935"
  head "https://github.com/grpc/grpc.git", branch: "master"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/grpc/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "5d31f9236c6a11563f4f180f831bcab9607777e5b35c5e01942de9cd41a9d620"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "836bc80b52e88966aa3a86cc8c959359bf18b168c9abd2a0a22e762adcb579bf"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "ef60f722677fb0ecebcf600bf5f0be3ab70998209124470d0057a38de9d7bcd3"
    sha256 cellar: :any_skip_relocation, sonoma:        "ab6b870ba9c27a46e95227845c512be21ad9c849456809c49787c9bf2e693685"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "1abff1dee83e683e229ae55908586c6ba235a632669f9816a0071b5475a41165"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "29aa69cc7ed2c1fc0db5734c3cae53b2ff41223712927aca1a91c585f9979548"
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
