# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT83 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "ac05558f982a8c7bda318514e72393d792a8d7fc7f0d1947ab1c8bb5e8504fa7"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "e03df10ee89823c18ed49a1a6ee04f8470a42273f57f104aea336c13369dfd15"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "d590042249b7451406b1aaadb754f26c25967ffeb84775a7f16463c98d530a72"
    sha256 cellar: :any_skip_relocation, sonoma:        "bf58bef99fe589e28aed537b616d48d56bc8309ad2446610ae5b6f6357107de1"
    sha256 cellar: :any,                 arm64_linux:   "ae0cf53bc8c5a2456cef9352f47ece49dbb39e781be8e71847cd9f7869ffb1f3"
    sha256 cellar: :any,                 x86_64_linux:  "72a111c6be73f34f4a7e53e2fd33c271d6ddbf77be44134c2fc0802148ed2b09"
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
