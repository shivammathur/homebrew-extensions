# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Expect Extension
class ExpectAT81 < AbstractPhpExtension
  init
  desc "Expect PHP extension"
  homepage "https://github.com/sibaz/pecl-expect"
  url "https://pecl.php.net/get/expect-0.4.0.tgz"
  sha256 "032ff2f92a9f95a2cb91d9e1c1b711c696e562ea57cdec8459954d8b0601d442"
  head "https://github.com/sibaz/pecl-expect.git"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/expect/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 3
    sha256 cellar: :any,                 arm64_sequoia: "9b8984e1b3ae97b343fb0a1a982a96ddfc3d04cb95b5e40d83f40906c94bc999"
    sha256 cellar: :any,                 arm64_sonoma:  "acbd9556ae050d070ef93524a5f677f3f0d8f971801f05cd1a72b6cdea95ca86"
    sha256 cellar: :any,                 arm64_ventura: "5ca1542340df71b202d7f30e66a364a0d65a465220c6022b3ea70ef57e64f912"
    sha256 cellar: :any,                 ventura:       "007fbae0a33d01e0a4237b0554069bb998c4d4eb6603f936111bc17d78c7a54d"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "8a126aa2f1994e58aa8e1fd91d91331e08befa5deaa21f213496537c9e98aa5e"
  end

  depends_on "expect"
  depends_on "tcl-tk@8"

  def add_expect_lib
    expect_lib = Dir["#{Formula["homebrew/core/expect"].opt_lib}/expect*/libexpect*"].first
    lib.install_symlink expect_lib => "libexpect#{File.extname(expect_lib)}" if expect_lib
    ENV.append "LDFLAGS", "-L#{lib}"
  end

  def add_expect_headers
    headers = Dir["#{Formula["tcl-tk@8"].opt_include}/**/*.h"]
    (buildpath/"expect-#{version}/include").install_symlink headers unless headers.empty?
  end

  def install
    args = %W[
      --with-expect=shared,#{Formula["expect"].opt_prefix}
      --with-tcldir=#{Formula["tcl-tk@8"].opt_prefix}/lib
    ]
    add_expect_lib
    add_expect_headers
    Dir.chdir "expect-#{version}"
    inreplace "expect_fopen_wrapper.c", " TSRMLS_DC", ""
    inreplace "expect.c" do |s|
      s.gsub! " TSRMLS_CC", ""
      s.gsub! "ulong", "zend_ulong"
    end
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
