# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Ds Extension
class DsAT84 < AbstractPhpExtension
  init
  desc "Ds PHP extension"
  homepage "https://github.com/php-ds/ext-ds"
  url "https://pecl.php.net/get/ds-1.5.0.tgz"
  sha256 "2b2b45d609ca0958bda52098581ecbab2de749e0b3934d729de61a59226718b0"
  head "https://github.com/php-ds/ext-ds.git", branch: "master"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "95d9b8ca15b34eacf6e29baa14f1033f23737e6ebeb5a34e312262c13562a52d"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "cd3ab527852f27fa5e0be7660ebd1bdadb5bbfe8c91fcccdb1d75a0468c3a929"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "96964033cafdccc3c40166fd045643a05dad56e1b9b49addaf4855321775daab"
    sha256 cellar: :any_skip_relocation, ventura:        "9b36bb6f5d149854b816fb40b6f6ba66b44125c5e15d008cc9ded111f5189eb8"
    sha256 cellar: :any_skip_relocation, monterey:       "e6b790e84f7343360c1b79ebfe887b6c163c0e075dc5d8da9aa3d684b4d3f62c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "5c42534f8b6b2bc03b2282d298d6354f7eda723d1e006ce0c9dd054574a60b72"
  end

  priority "30"

  def install
    Dir.chdir "ds-#{version}"
    inreplace "src/common.h", "fast_add_function", "add_function"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-ds"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
