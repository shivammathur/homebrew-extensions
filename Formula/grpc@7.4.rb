# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT74 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.66.0.tgz"
  sha256 "6f6b751bbf33a88f917ca11a5b32923223c106eb5f064b791f99c6f7a9c7e7c2"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:  "be3c4781d4e24f71acd007c621c1399044ebaf0ba9c3bb09ae0595d111bc0575"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "f8f97e97a1911fa85baeb88feff93b2d96fc048cfa42f63acc4c630d6887f432"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "48b1f81a47b0b022c036e4994459f56b26b7f0efff50bccc5678494206d6c3e1"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "eb9e37fc08d5e4fb72adab9c81e5ac6291a89e7963907466b68fa1bbc3a34b2c"
    sha256 cellar: :any_skip_relocation, ventura:        "3b099752a871feb7fdefdb920b22e9bc6cb8e303601e0ec6f8a4b952f705dfcc"
    sha256 cellar: :any_skip_relocation, monterey:       "1dc90fa2bca26f7b03b391e758c57024edf6323a48731c630bcddd42189054e1"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "8dedd7546138f348ad0d5a8e8b145b1f909d3796a708be84dd330b5bdc0b6955"
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
