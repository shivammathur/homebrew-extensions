# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT71 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.61.0.tgz"
  sha256 "7efeff25faac9b8d92b3dc92e6c1e317e75d40a10bdc90bb3d91f2bf3aadf102"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "2f019cf5ee2e8807bcec755cbe96759e6176a303c4b22bead3ebb1f88da7ee47"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "13066c098372aa3f60c8b58f935d3f01228c2f18d3c1a4c044299d6a94d8b9c3"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "4a17cd15e5347e9def1448eb354685c9b440786ff4017ba4cb3f186cfe36ffa0"
    sha256 cellar: :any_skip_relocation, ventura:        "c8b1aaf39dda1a3816647195faf8be2c08490e873f653d847540e89f8dcaa49b"
    sha256 cellar: :any_skip_relocation, monterey:       "8165dccc43ed56a8fb8b0bca031fcb5c9e93af9dfa2dc53d76645291c88e4604"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "a13e4860e8b435404bb6030f70049a5e565e463c0b448ec7efc54aabc26f6460"
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
