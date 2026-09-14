# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT82 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_golden_gate: "0969add41c218454e7511f9e9031ddd4c3a99209c3761ced47514ee4568785df"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:       "040069195cb15540bc3c7427c50280d4b8562417e3c7e8b0ee4ecb226fe0c4c5"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:     "1439a35a62edcbe79f13b3da53be7f6f3cffd04e1eade565370e1fbc6b4970d9"
    sha256 cellar: :any,                 arm64_linux:       "a0c1c543dad81b929a41b52c07c31ae4902c28026d44c7dd25b12ccbe1f89d7a"
    sha256 cellar: :any,                 x86_64_linux:      "f1809e249038c38b1d2295a6b131c01718ceada941baf2f84fb40f3a84029a3a"
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
