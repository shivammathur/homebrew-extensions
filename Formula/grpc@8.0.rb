# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT80 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "1f5d8e6fc0da7e820499a49bbc69c1b4849279f63f8c2623d697225f86665c33"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "642b5516b2d9cdb4b4d7aba8d7a16b68871222d40efee5030ae8182522433d93"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "7761499347e6e60470f92b487444129296f3dd88620d2dc699d160894801d0a4"
    sha256 cellar: :any_skip_relocation, sonoma:        "7f5d6bb6238f48edef1f604d580b6e50761702ef831b1ea78deb5a4e89c42778"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "a323a4ade8676b3e827d624ac5bac9b812de04bbc5e0895ac07372c15886e9dd"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "ae4fa081b6fdd35f9ab760041b2c33814a6856d319bd0b90425cf92bd8dcb942"
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
