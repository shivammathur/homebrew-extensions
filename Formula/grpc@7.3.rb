# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT73 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.84.0.tgz"
  sha256 "555716233a5cc9a6baa605719f87b7688a88fb8bfdd9b4493396276244d56625"
  head "https://github.com/grpc/grpc.git", branch: "master"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/grpc/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_golden_gate: "fd9c8488d4eba4c6971780994e63f770533054d067ff36a5f26c46d2a78d5801"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:       "129b7834f8ff88cc8406ee5520a0e37b8acfdd3e876f256e27f4a65a61edc8a6"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:     "51bf9620aa348bd2092b9727e7000da66d661f5e4a51d747dd9a749db2b193b7"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:      "7cab7aee2ee93fd85bd1aff049afcf9bf80efcacb3a1130aa4f9924f9e91ee60"
    sha256 cellar: :any,                 arm64_linux:       "e28550cc2105bfbeeeaa290d2df1523185884729e4c0ba5037adb623faee9eb6"
    sha256 cellar: :any,                 x86_64_linux:      "055c6181201d320de53dbc21ccaa8098ffffc9d0fcfa3062f693cbc57683a756"
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
