# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT74 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.82.0.tgz"
  sha256 "bbcb83e229b565feac351bd88bd80091c4ef613357122fccf8a9930cd988d6ca"
  head "https://github.com/grpc/grpc.git", branch: "master"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/grpc/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "d6c99c679e264e0e2247d59d34fe9e76a2db87a7756f34be6fdeb146ae6d3860"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "98ecd728ff4b81ccf0d894a0aef4f95646a2d35801ced40ffb41adcddb501cdf"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "624f30a98580017f3b8d379dda2b0f80d86c32746eed2e8ee477c112d2d86979"
    sha256 cellar: :any_skip_relocation, sonoma:        "f01389921722daa5dd861412cd257d6658f3843b633af0951833384d08b2f62c"
    sha256 cellar: :any,                 arm64_linux:   "6ed50660b8983ce589674eb2d4b9dccf7c25fa7ad88242711cbcd94ceda3ca55"
    sha256 cellar: :any,                 x86_64_linux:  "f85117dceba9f701f40fa310c64408744ae8d4bc1cb735c9cf9b8a7fe050f156"
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
