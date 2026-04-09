# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mailparse Extension
class MailparseAT80 < AbstractPhpExtension
  init
  desc "Mailparse PHP extension"
  homepage "https://github.com/php/pecl-mail-mailparse"
  url "https://pecl.php.net/get/mailparse-3.2.0.tgz"
  sha256 "cc5111ae17bfa36efcc5ef23dcf75b6501593ac264c196aad3e39cd4ad765332"
  head "https://github.com/php/pecl-mail-mailparse.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/mailparse/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "0617029303efee13497271882c665db4c83fce02daad59c26196835361409f24"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "f7969a6497fb5533d5c1ebf929f0ac14d367aa39dec9340e2616708828f354e2"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "71af9604e0bc4c8687b3ee39e4ab59bfaaf02e25b52f87da9131abb6c25e77ef"
    sha256 cellar: :any_skip_relocation, sonoma:        "13d7afa56dd3a9915a7d40f0a5437c773cf29b377dba119c5422bca02cb92d74"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "23170b6df09f1c2c0966e514cc441f398dbccbb6ed312d7b86fd6478681551ba"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "32e54999167e6df8f4fa6b0ca3293bdc82e230002583487af51d5b67478b98df"
  end

  def install
    Dir.chdir "mailparse-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-mailparse"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
