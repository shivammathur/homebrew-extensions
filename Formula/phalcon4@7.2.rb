# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

class Phalcon4AT72 < AbstractPhpExtension
  init
  desc "Full-stack PHP framework"
  homepage "https://phalcon.io/en-us"
  url "https://github.com/phalcon/cphalcon/archive/v4.1.3.tar.gz"
  sha256 "d6f157e033c7ebfd428190b7fe4c5db73b3cd77e8b8c291cf36d687e666a6533"
  head "https://github.com/phalcon/cphalcon.git"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:  "50dd6b680b72049814c076b4ddcd217b16af9b0be687adac2b6521f0a47c696a"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "d43f5d4e269b7aa4be743d01596663c41ca6bddef0e5a6b852b00c0dae618b75"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "051b7731ffd4b9401fe41cf2df91ea408b83afd0852c428e11b2fb21ad9d328b"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "ec23351a168a701df611e992ab3024490f3358a2aff75ff67991028eb8560555"
    sha256 cellar: :any_skip_relocation, ventura:        "71d559605985f7e7eb7045931e555cda1033cc435d475bf58319a86667c4962a"
    sha256 cellar: :any_skip_relocation, monterey:       "391d69f873abf6341e8c91e18c54db18803b7aaffe85d3f7b004aee899a16f52"
    sha256 cellar: :any_skip_relocation, big_sur:        "6bc3df6426aa7380bddb5a06ff97e43693321446d4e10b65efeeaaa086e8cdef"
    sha256 cellar: :any_skip_relocation, catalina:       "48118ae7b6a7e0f35384462142c4469471b4b03c260297ae260883b5abf3c82b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "422259f1e293a2a5b60ef14b1f8dec927e2400ae6c9657c0d0586f3946d51a17"
  end

  depends_on "pcre"
  depends_on "shivammathur/extensions/psr@7.2"

  def install
    Dir.chdir "build/php7/64bits"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-phalcon"
    system "make"
    prefix.install "modules/phalcon.so"
    write_config_file
  end
end
