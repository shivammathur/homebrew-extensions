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
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "ea04adf57ccc47ae3db9371b0ccd3db07daca0efe88f497c2b7fb4c92ad094bd"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "bbb3d9eee46e54c96de9bb40552ef6918f3fdc72efa8ab87159b340f73de6fea"
    sha256 cellar: :any,                 arm64_linux:   "583064f094affea64981c055b2c6d933d4518d5904d1487ea90bf373c7d39bed"
    sha256 cellar: :any,                 x86_64_linux:  "4dfe2fb469db9dfd86927bbbbd1df8f61719ec18dcb328d973e759274bf1a3de"
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
