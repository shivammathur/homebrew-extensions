# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT83 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.65.2.tgz"
  sha256 "5efbfd399f3be464e293bb0ec4a773fae9bb4a43b67362e1fac72bb4cae4bbc3"
  head "https://github.com/grpc/grpc.git", branch: "master"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "753ecc12d5b3aaf850b0821569c3eb0f34196f2aecf17729ca41ca3905ca4e3c"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "9f0b19a22995c0d58a118adf3ee5c6fcae2f826f8b9ac40697e31863a78b439c"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "9dc65c573d14702bc68adbc1bf22575b517fbe982d1541869bd8d373390f693c"
    sha256 cellar: :any_skip_relocation, ventura:        "57a2073bed3b908376ac273021f544db9db96720aafae80bec08f5755dbd5101"
    sha256 cellar: :any_skip_relocation, monterey:       "a0ba3a880120be20e70125f2206a06a142f1c550de99225f455d07d3a470aa80"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "fa15612ace0f84aa92c4f5c172a3def95833874657362cefa10c320bd1c216c0"
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
