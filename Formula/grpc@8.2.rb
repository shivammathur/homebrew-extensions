# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT82 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "248d5f8fc0431ecd79dcafbfc03282db8b698fa259527b0e81e19e3ab71e90a1"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "15f0e72b4549ad1cf37a5cd513f3d6fd713bef8a31eb1ea62edf155fb6141569"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "e3a60f8d3e48070634340c90d317d41c1863abb7448b78edb37410127793d987"
    sha256 cellar: :any_skip_relocation, sonoma:        "fa53addaa24750840cd4b8323b13666e7629b13b7703db567c73a6d70b5e8681"
    sha256 cellar: :any,                 arm64_linux:   "0f78e657f4dc6bb51f3efb75baca0a2bf125f0299edd3ed2f2258ca49573aaf9"
    sha256 cellar: :any,                 x86_64_linux:  "e11f833e843b0cef79339f929b178c187c9a47880a4d4ffcf6af4fff66c07d69"
  end

  depends_on "grpc"

  def install
    Dir.chdir "grpc-#{version}"
    patch_spl_symbols
    safe_phpize
    system "./configure", "--enable-grpc"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
