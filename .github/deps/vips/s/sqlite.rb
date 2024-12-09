class Sqlite < Formula
  desc "Command-line interface for SQLite"
  homepage "https://sqlite.org/index.html"
  url "https://www.sqlite.org/2024/sqlite-autoconf-3470200.tar.gz"
  version "3.47.2"
  sha256 "f1b2ee412c28d7472bc95ba996368d6f0cdcf00362affdadb27ed286c179540b"
  license "blessing"

  livecheck do
    url :homepage
    regex(%r{href=.*?releaselog/v?(\d+(?:[._]\d+)+)\.html}i)
    strategy :page_match do |page, regex|
      page.scan(regex).map { |match| match&.first&.tr("_", ".") }
    end
  end

  bottle do
    sha256 cellar: :any,                 arm64_sequoia: "7eca69ad4697874a907a2eb2ae60ceec930d93e92796b3433b65fc7c65a8dbaa"
    sha256 cellar: :any,                 arm64_sonoma:  "725168435181011bdd06d7d1f18dad719529aec4ae0176392b0a16a725612b37"
    sha256 cellar: :any,                 arm64_ventura: "3ab78c5df09c610070f4a64a8fc55e4ef5037de719e9361b8e30dd00590bd510"
    sha256 cellar: :any,                 sonoma:        "03bd52415c045f9ee4cc5c9e4711aee2872ca186cca60c8c7f6296fec8d3e87c"
    sha256 cellar: :any,                 ventura:       "0f2d1a76178f1da4bfbc684b8e4a0393bb18ff6ed4a24261aa66b3d2e2011f04"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "082aa7c1c531ca9f74fbc8833fcf8459f985c11bdf5164e2ea4a820d479497ae"
  end

  keg_only :provided_by_macos

  depends_on "readline"

  uses_from_macos "zlib"

  def install
    # Default value of MAX_VARIABLE_NUMBER is 999 which is too low for many
    # applications. Set to 250000 (Same value used in Debian and Ubuntu).
    ENV.append "CPPFLAGS", %w[
      -DSQLITE_ENABLE_API_ARMOR=1
      -DSQLITE_ENABLE_COLUMN_METADATA=1
      -DSQLITE_ENABLE_DBSTAT_VTAB=1
      -DSQLITE_ENABLE_FTS3=1
      -DSQLITE_ENABLE_FTS3_PARENTHESIS=1
      -DSQLITE_ENABLE_FTS5=1
      -DSQLITE_ENABLE_JSON1=1
      -DSQLITE_ENABLE_MEMORY_MANAGEMENT=1
      -DSQLITE_ENABLE_RTREE=1
      -DSQLITE_ENABLE_STAT4=1
      -DSQLITE_ENABLE_UNLOCK_NOTIFY=1
      -DSQLITE_MAX_VARIABLE_NUMBER=250000
      -DSQLITE_USE_URI=1
    ].join(" ")

    args = %W[
      --prefix=#{prefix}
      --disable-dependency-tracking
      --enable-dynamic-extensions
      --enable-readline
      --disable-editline
      --enable-session
    ]

    system "./configure", *args
    system "make", "install"

    # Avoid rebuilds of dependants that hardcode this path.
    inreplace lib/"pkgconfig/sqlite3.pc", prefix, opt_prefix
  end

  test do
    path = testpath/"school.sql"
    path.write <<~SQL
      create table students (name text, age integer);
      insert into students (name, age) values ('Bob', 14);
      insert into students (name, age) values ('Sue', 12);
      insert into students (name, age) values ('Tim', 13);
      select name from students order by age asc;
    SQL

    names = shell_output("#{bin}/sqlite3 < #{path}").strip.split("\n")
    assert_equal %w[Sue Tim Bob], names
  end
end
