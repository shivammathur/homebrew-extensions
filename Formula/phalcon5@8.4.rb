# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Phalcon5 Extension
class Phalcon5AT84 < AbstractPhpExtension
  init
  desc "Phalcon5 PHP extension"
  homepage "https://github.com/phalcon/cphalcon"
  url "https://pecl.php.net/get/phalcon-5.21.0.tgz"
  sha256 "e7e81858b2dc11f578a3a8c4924b37d86bec67945bcca725bc34a51ba50c43f0"
  head "https://github.com/phalcon/cphalcon.git", branch: "master"
  license "BSD-3-Clause"

  livecheck do
    url "https://pecl.php.net/rest/r/phalcon/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_golden_gate: "6863ec0f1e951e845df0497b7011872690cbe7039e7fe8eb0806ccf5de806dd4"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:       "97a136a1e5f99f9be5c2854f2a26e52a268ad1c45963a47f8db768696f53ef3a"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:     "17ac70a1eeaf33ceded355a15bd132deeda143453e7efab66e4f5278c2b4f9d3"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:      "0eb9d46c47e3f906da1a60ba6d3f6262ba609fd9853274009b22df229fdb0b84"
    sha256 cellar: :any_skip_relocation, sonoma:            "e1519f02feba3450aa892cef4116c7a27f145b3c44f6de42bc05de9f679273f7"
    sha256 cellar: :any,                 arm64_linux:       "273366667d8f3f0e4e6bc6ab3b46912fd3a099139b8fabc9ca7b7ad67b533c49"
    sha256 cellar: :any,                 x86_64_linux:      "e7839c9a4a345313c53a892091ef8783b65cc2b25801d256b882de5b422e7f13"
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
