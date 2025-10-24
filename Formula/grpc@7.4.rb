# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT74 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "1062612bac4843deb5d8f4439832aef6017c44fc61c8e1095b2e93dadcbe6571"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "65e4333edf74b56268ef55e49d069cc4ddf369711444f3ce887bf15ce4694523"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "7effe9adac9d0d30cf7b501adc83fa13e12a032855f8871340e961f2fdb6c66a"
    sha256 cellar: :any_skip_relocation, sonoma:        "1df16b7ae787bb925d5c265fbfa54c6c689618c8402557bfbc74fe11421947b2"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "b871295a3e213f3ff9c7c2e21189beb4b39dd1aec9923a8965aa21997239aa92"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "b12d484f423bd92373bf5507fb9e5d98c2c54aa0f23fd3fa206f40d76fcaaab0"
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
