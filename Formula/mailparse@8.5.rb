# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mailparse Extension
class MailparseAT85 < AbstractPhpExtension
  init
  desc "Mailparse PHP extension"
  homepage "https://github.com/php/pecl-mail-mailparse"
  url "https://pecl.php.net/get/mailparse-3.2.1.tgz"
  sha256 "a9f092ae84f32f15149a09a9a278bb20d3794cbfb57893eab4933814d7ab2fd5"
  head "https://github.com/php/pecl-mail-mailparse.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/mailparse/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    manifest_sha256 "3a8ee170ca6d47993d2ae82cfcd29af419e3ff96cd035863eca9410ee240490d"
    sha256 cellar: :any_skip_relocation, arm64_golden_gate: "bdc53b1da8448f24cb700956d8b959af5f9d7562521ea355f98ddeb25c8d7322"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:       "96d632972b454dfe5aa446feb7cd2376b01941dc200a9b9654dfb8c0d2cb8c04"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:     "20a0ca6b44a8b7917f5498bc5ae9e57343a8818cc080ff2dcad50e51814123ed"
    sha256 cellar: :any,                 arm64_linux:       "78ce836f9244867ecb78ac5d878aabc9b0ee2e69f31289c944d05b2af5d61a55"
    sha256 cellar: :any,                 x86_64_linux:      "83b3830e0a53790799a689258897fa60146f65bfcaa50e14159727abe26ed8a0"
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
