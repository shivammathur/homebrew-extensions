# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Raphf Extension
class RaphfAT56 < AbstractPhpExtension
  init
  desc "Raphf PHP extension"
  homepage "https://github.com/m6w6/ext-raphf"
  url "https://pecl.php.net/get/raphf-1.1.2.tgz"
  sha256 "d35a49672e72d0e03751385e0b8fed02aededcacc5e3ec27c98a5849720483a7"
  head "https://github.com/m6w6/ext-raphf.git"
  license "BSD-2-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "6f828ddb01134c57d9d8aaf8a5c739671f6a7744995a80a0bc5040b29b5216c2"
    sha256 cellar: :any_skip_relocation, big_sur:       "cc06f69d08d8d5b9710ab5858c799788e7a1662361e1640902b819b379006ff9"
    sha256 cellar: :any_skip_relocation, catalina:      "50b3b5781c82add904f128e5c8b82b2da2543093feab1e1c41a1cfb8744d257e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "f59b8af341853d110ff905bbacb4e5da172a42d7de7331a0893299ab63897d34"
  end

  def install
    Dir.chdir "raphf-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-raphf"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
