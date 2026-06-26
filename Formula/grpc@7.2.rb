# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT72 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "63aa31d2a33cdbc6efaf4576a93658e6a85c245c430fb39a79eb90f28e27390e"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "dde06bb8178f6e01159059b43b2f93e3bf2608c59305831d6dfaca9196957eb6"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "c3d9fd03af14825c3bf7d1079abeb6fb88875ad60c04884aa334256330234d63"
    sha256 cellar: :any_skip_relocation, sonoma:        "4ed051dd169d5baac0e8f18c87bc6c10c4fb67800b14e4787cc1527b1d106ef5"
    sha256 cellar: :any,                 arm64_linux:   "6bbe5244813a24a99aa7e3fe1441d2f8b26e9d4e8d1526295e8e249931582e95"
    sha256 cellar: :any,                 x86_64_linux:  "9138f87130bd8efcc27cd84759fd202a4286ba949d507819c796d3247c2b2f5c"
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
