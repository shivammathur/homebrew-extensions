# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT80 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.50.0.tgz"
  sha256 "2e0bebc351d9cb07ef1d3685f3c4f976d297bbf946479c5e4be4ecaaa3500927"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "b8d9dc6f6e983a26affaef43437c716527791ceb705f4eb53479f4c357c2ecaa"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "4e65277acc802b8a6c650d6535f85bbe27d5757accc1763573494656c716528e"
    sha256 cellar: :any_skip_relocation, monterey:       "da2a0fa52097b6a3508d2752cb1ebae77cf60c536cf0994268fba30d64c2481d"
    sha256 cellar: :any_skip_relocation, big_sur:        "214e7d9bbe5cca198acde513d44c0eac925e8f0b3abcc60f0b34034a3f5b0d02"
    sha256 cellar: :any_skip_relocation, catalina:       "9f50e6adf319b949a68ef68eb1900e7f0594015df432507a463179b0a4b60e1b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "e49498bae7fb16dc678112ec3afc2147e703eacae58a4e7f840acd7549437c93"
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
