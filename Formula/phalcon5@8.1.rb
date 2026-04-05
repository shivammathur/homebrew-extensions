# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Phalcon5 Extension
class Phalcon5AT81 < AbstractPhpExtension
  init
  desc "Phalcon5 PHP extension"
  homepage "https://github.com/phalcon/cphalcon"
  url "https://pecl.php.net/get/phalcon-5.11.1.tgz"
  sha256 "8331f47cf760dbaf13ae2d77d63971005b03df40279dec97ede4b537d14c9591"
  head "https://github.com/phalcon/cphalcon.git", branch: "master"
  license "BSD-3-Clause"

  livecheck do
    url "https://pecl.php.net/rest/r/phalcon/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "8e50e1f5da5625c26de263ee1b18241c50f03beadb7d4a3bf7fd88b89aa2609a"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "0f3e12667b70b6500bda73331b01f499b41f0a89d00b1e95d40b8b2dbb2265ca"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "4bd7c4cc6f398c72c54f5961205e03b356ac79d729af9254ce7eeeea6962c201"
    sha256 cellar: :any_skip_relocation, sonoma:        "deb46bc467d4606dbf3fcbd6bea88b13e5cf7cf1e107ba77f3f8ca2e1ec75a5e"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "7ef55e2b20e3f8f2e8ae3594b0a87ab0a32f7f0828dfa7931582696586f3c3ce"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "49c3c6d1201e2eb3659b346bae32aa5ad2cdde338dc97e3f6c258553ca505f69"
  end

  depends_on "pcre"

  def install
    Dir.chdir "phalcon-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-phalcon"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
