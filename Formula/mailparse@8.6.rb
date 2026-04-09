# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mailparse Extension
class MailparseAT86 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "dff561e407141d77ab82f3641fd81e0bb3e3a5f804a31eba0d0db52dca557b77"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "0cf21963ee4de27732ad82ac5fb29c669bfc9bb24f2e2707aca6366fb21795d4"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "99eba05c5c9be6c8d94aa33cce3f244a99612409fc93186592a88ed8437e9fbd"
    sha256 cellar: :any_skip_relocation, sonoma:        "a33ff6385be3c56684d9f918f5a7d4289fb6101f38afbd9276c84c29e1e1faa5"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "4dda1ee5c5610fca81f28f1fa763225d1722b6ca9f5940ad1f21049121cad233"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "bb056ffbd3ea75f8686db13fd6daca105710ec7979dd879c9a70e04b04da8bf7"
  end

  depends_on "re2c" => :build

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
