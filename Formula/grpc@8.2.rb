# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT82 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.78.0.tgz"
  sha256 "c846ac9164930897fea9c55bad52aeb9f99a03cce64e694bd80f781c59baa0a8"
  head "https://github.com/grpc/grpc.git", branch: "master"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/grpc/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "3590a4f51becdaf9546dd8cc71d34f85caff5534d4d5890283c0727605d4dba7"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "1188c357817ac7045b2560990fa945db8823c423e6399336c326227c8ddf8cbe"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "5be46e6073c6d8685039517208a45da69e77ddc04bfaa6f8b128ba989c0cb588"
    sha256 cellar: :any_skip_relocation, sonoma:        "7e98c0b7a795297b27b350029babfddba64875e05cf5ec04c84a25fe14f28a25"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "4b07cfbc473129137ad587da4a7bb1018cbcfbbfc3ff55857a72a83645654bfc"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "975ceec05b3a3bf0e29cbea41177588dd31a86274cce469a8c7f71cef7efd884"
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
