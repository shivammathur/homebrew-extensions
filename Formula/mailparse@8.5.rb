# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mailparse Extension
class MailparseAT85 < AbstractPhpExtension
  init
  desc "Mailparse PHP extension"
  homepage "https://github.com/php/pecl-mail-mailparse"
  url "https://pecl.php.net/get/mailparse-3.1.8.tgz"
  sha256 "59beab4ef851770c495ba7a0726ab40e098135469a11d9c8e665b089c96efc2f"
  head "https://github.com/php/pecl-mail-mailparse.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/mailparse/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "17241fbf0f7f1143ce44d673efafbda6031fab1d4a9bff9bd24660f1488df954"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "339b19f07eab38bfe36702820d4a1437537498501e951379730ecbc01558e2fc"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "94175ceee0267f61dfe0118433e137c9169df1ead631584a2b195448cea94099"
    sha256 cellar: :any_skip_relocation, ventura:       "62dee4b8ca6715e4590986c6f589145093ed2608721bf7f8153c93c35547c667"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "f2f4b72ec042f0aba2df4c749abf274d6a5862d8199b129927d178b4f11c3327"
  end

  def install
    # Work around configure issues with Xcode 16
    ENV.append "CFLAGS", "-Wno-implicit-function-declaration"

    Dir.chdir "mailparse-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-mailparse"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
