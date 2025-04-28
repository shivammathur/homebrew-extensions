# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT80 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.72.0.tgz"
  sha256 "715fe230c0b185968e92f8f752d61a878f9eb5346873848e47ff65d0af6947dc"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/grpc/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "31fb07027fa3b59f10410e0958b52f680e337d797a366fcca29e0916b03dd37c"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "4f693e0f377304dd059c3e882482e47991457c8fef8cb9dad58596faf4418460"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "fd33b7873fbc1d5e175d5bff490e5f7ebc05ea12dcbc06117355912d3419a4e1"
    sha256 cellar: :any_skip_relocation, ventura:       "bcaa21a851240e1c22fd249911fbe8d9d9ba3ef0efea8103f66229c7e5554c9b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "f1a7f9e89a9223c41752372dd9b99da8b2c66589bd432fc1cba36b54646dc6e4"
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
