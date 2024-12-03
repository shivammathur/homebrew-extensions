# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT82 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.68.0.tgz"
  sha256 "4e022e052d5b7997efd42f3b67f1175dbbb772cfd435570852febc0f569065bb"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:  "a40b0e93a4b0b531f6924ff67bec3a4ec067378a60834ac04017b09cf12ea982"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "9128e41aa9028514420f9366718fa50773a72518f5f4dd5fb187423fd089ee3b"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "6526fa82dafb0829c99e50ef75b3c845f6839c80349d97fcc6046e4508d40899"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "8d91588f7f017b6276d115a75ae0f0f69434b5540a7ec2d8b4121fb45169efe3"
    sha256 cellar: :any_skip_relocation, ventura:        "9230feb87d9acb3857f9193abad2afa3debe13ca7d34a2e6eb3d2d2d67cd8cd7"
    sha256 cellar: :any_skip_relocation, monterey:       "f2af5f44f6db8d364e40bb838659a467789dd6a9fd9cba2ae1e3384ec3908acf"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "4ff0678a83efd0ea75371d22dca251cc55e8b70acf46608aedd346ff6bd40cfd"
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
