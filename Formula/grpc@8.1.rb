# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT81 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.82.0.tgz"
  sha256 "bbcb83e229b565feac351bd88bd80091c4ef613357122fccf8a9930cd988d6ca"
  head "https://github.com/grpc/grpc.git", branch: "master"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/grpc/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "cdb556620be1517033f142749639bd3b6dada0f3d6a99bf43aa86d5c72a01a3e"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "0de13e04df5c82256a57a96b614bbf4064e0cdf8e3fc14f020a67c57110bc573"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "7c04bcd6345fb3e2c723ec6f03171208f99db4da79a9d555e5b7812b39adfc03"
    sha256 cellar: :any_skip_relocation, sonoma:        "f5a070bb634b83ef11009ac75e79f26d3b643e9de08315239f31737276678536"
    sha256 cellar: :any,                 arm64_linux:   "2c1905593745514c993c17c469d67b235ba555239b6395206c3881c2805452a8"
    sha256 cellar: :any,                 x86_64_linux:  "2544f43d4818a37fd02cacb1af1365e65e6bd07d6cb1def7329ebbfa40247b1b"
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
