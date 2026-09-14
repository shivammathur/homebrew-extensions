# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT81 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_golden_gate: "84a67adbd0d26818f1f1a79a971a138e1317d6207c0e323b0750e83a5bf4fd6b"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:       "b34db5e4af344259e33a1f957da6c70c52d849f3816dbe45d9b45d562f2055df"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:     "70d38deb13b99c4827baabb46a1a35312699133c36f54b0320d71f77a253e8a1"
    sha256 cellar: :any,                 arm64_linux:       "1941a25c6ec42c1c91126f8104b120239d754f6e57c8a9ad4f737df393611814"
    sha256 cellar: :any,                 x86_64_linux:      "be9571cc3ae33ae8aa58cd8f1bd69c1bb0eddd3838078529407b6a262c794c07"
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
