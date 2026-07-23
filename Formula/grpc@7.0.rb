# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT70 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.83.0.tgz"
  sha256 "b12c7e0e048df728a4f2c513aeaa78ae18ad5c3ab3b607eeae398e0e1bab12ea"
  head "https://github.com/grpc/grpc.git", branch: "master"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/grpc/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "ecf72311b6207241f58275d1ea5b211f04f6ea89aeddea8a690f87db9f6bb16c"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "9f45b0139a4ff3de391bb0704722fa44c34bad3086f28f5c32a00200339c4877"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "4ac45949f68661813cb2021422c11277b45188d9a3e2c0c1443362ab45c8432e"
    sha256 cellar: :any_skip_relocation, sonoma:        "a8838e9eeef71e7df540d8eb6bf0ba0b313b0dec2ec4fb869875adad8a146af4"
    sha256 cellar: :any,                 arm64_linux:   "cbdba35631e34d13c914328d051d76a3dc9b3d6e459b45bebecee81bc826d030"
    sha256 cellar: :any,                 x86_64_linux:  "59d5c4220f99cb039f09ee213e72688d84d9bafa2883beda3fbb356900e7c837"
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
