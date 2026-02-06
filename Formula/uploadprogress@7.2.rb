# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Uploadprogress Extension
class UploadprogressAT72 < AbstractPhpExtension
  init
  desc "Uploadprogress PHP extension"
  homepage "https://github.com/php/pecl-php-uploadprogress"
  url "https://pecl.php.net/get/uploadprogress-2.0.2.tgz"
  sha256 "2c63ce727340121044365f0fd83babd60dfa785fa5979fae2520b25dad814226"
  head "https://github.com/php/pecl-php-uploadprogress.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/uploadprogress/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "5484ffe3b27b909df2dbb6662af2a03e016871f705774ec7419fb49bdfc71540"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "c6d604888c20dbbe9df49fd1012fd827e3f3569e81110835300bfa026236e6f5"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "3734bb673c1c5fb2e019057a5fb631083e054c5fb8a608f3a446adca640cbe8c"
    sha256 cellar: :any_skip_relocation, sonoma:        "abaf1837f55908f2f9110fd298552815d66e67e5762a87b5be177a52bac455c8"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "3329ed5d2a83c12e43d6fb5b648d7572a7ca20677d784db4d493ae88e82b337a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "201777ec599e3479e018e038379f4f9ba1d69a9e1f861a2fe2099d50ffd75e84"
  end

  def install
    Dir.chdir "uploadprogress-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-uploadprogress"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
